require 'net/http'
require 'open-uri'


class Question < ActiveRecord::Base
  validates_uniqueness_of :so_id
  has_many :user_questions, dependent: :destroy
  has_many :users, through: :user_questions

  def self.find_difficulty(question)
    owner_reputation = question["owner"]["reputation"]
    owner_accept_rate = question["owner"]["accept_rate"]
    if owner_reputation < 10 && owner_accept_rate == nil
      1
    else
      10
    end
  end

  def self.pick_question(user)
    Question.all.each do |question|
      #eventually update to assign questions as uniquely as possible to different users
      if !(user.questions.include?(question.id)) && question.difficulty == 1
        return question
      end
    end
    return Question.last#if all questions have been seen, return this
  end

  def self.get_questions
    path="questions/no-answers"
    #could be: answers, comments, tags, badges, users, events, info, posts, privileges, etc. ##https://api.stackexchange.com/docs
    todays_date=DateTime.now
    last_week=todays_date -7 # you can add and subtract days like this
    last_month=todays_date<<1 ##use << for month back, and >> for month forward: don't add days becuase the month before or after could be different form just 30 days apart
    # Time.new.to_i #1416453727 nanoseconds since the Unix epoch
    ##using one month ago to today
    from_date=last_week.to_time.to_i #convert from DateTime, to Time, and then to integer nanoseconds from the epoch for use in the api
    to_date=todays_date.to_time.to_i
    host_path={host: "api.stackexchange.com", path: "/2.2/#{path}"}
    query_params={key: "1iawbhuf9MxT2X77q)tvUA((", page: 1, pagesize: 100, order: "desc", sort: "activity", fromdate: "#{from_date}", todate: "#{to_date}", tagged: "ruby", site: "stackoverflow", filter: "!-*f(6rwhz2k1"}#this filter shows the total number of results in the hash

    uri=URI::HTTP.build(host_path)
    uri.query=URI.encode_www_form(query_params)
    response=Net::HTTP.get(URI(uri.to_s))
    data= JSON.parse(response)

    data["items"].each do |question|
      self.create(title: question["title"], url: question["link"], body_html: question["body"], body_md: question["body_markdown"], view_count: question["view_count"], owner_id: question["owner"]["user_id"], owner_reputation: question["owner"]["reputation"], owner_accept_rate: question["owner"]["accept_rate"], so_id: question["question_id"], difficulty: find_difficulty(question))
    end
  end

  def self.delete_answered_questions

    so_ids = []
    urls = []
    so_ids_str = ""
    
    Question.all.each do |question|
      so_ids << question.so_id
    end

    so_ids.each_with_index do |so_id, index|
      if index != 0 && index % 100 == 0
        urls << "https://api.stackexchange.com/2.2/questions/#{so_ids_str[0..-4]}?order=desc&sort=activity&site=stackoverflow"
        so_ids_str = ""
        so_ids_str << "#{so_id}%3B"
      else
        so_ids_str << "#{so_id}%3B"
      end
    end

    if so_ids_str != ""
      urls << "https://api.stackexchange.com/2.2/questions/#{so_ids_str[0..-4]}?order=desc&sort=activity&site=stackoverflow"
    end

    urls.each do |url|
      response = open(url).read
      data = JSON.parse(response)
      data["items"].each do |question|
        if question["is_answered"]
          current_record = Question.find_by(so_id: question["question_id"].to_s)
          current_record.destroy
        end
      end
    end

  end

end
