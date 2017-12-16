require 'http'
require 'ostruct'

# QnA Client
class QnA
  BASE_URL = 'https://westus.api.cognitive.microsoft.com/qnamaker/v2.0/knowledgebases'.freeze

  # attr_accessor :knowledgebase_id
  # attr_accessor :subscription_key

  def initialize(knowledgebase_id, subscription_key)
    @knowledgebase_id = knowledgebase_id
    @subscription_key = subscription_key
  end

  def generate_answer(question)
    response = HTTP.headers(
      'Ocp-Apim-Subscription-Key' => @subscription_key
    ).post(
      full_url(:generateAnswer),
      json: { question: question }
    )

    case response.code
    when 200
      x = OpenStruct.new(response.parse['answers'].first)
      x.answer = normalize(x.answer)
      x
    else
      response.code
    end
  end

  # def generate_answers(question, top = 1)
  #   response = HTTP.headers(
  #     'Ocp-Apim-Subscription-Key' => @subscription_key,
  #     'accept' => 'application/json'
  #   ).post(
  #     full_url('generateAnswer'),
  #     json: { question: question, top: top }
  #   )
  # end

  def update_kb(add = [], delete = [])
    response = HTTP.headers(
      'Ocp-Apim-Subscription-Key' => @subscription_key
    ).patch(
      full_url(:update_kb),
      json: { add: { qnaPairs: add }, delete: { qnaPairs: delete } }
    )

    case response.code
    when 204
      'Success!'
    else
      response.code
    end
  end

  def train_kb(user_question, kb_question, kb_answer)
    response = HTTP.headers(
      'Ocp-Apim-Subscription-Key' => @subscription_key
    ).patch(
      full_url(:train_kb),
      json: {
        feedbackRecords: [{
          userId: '1',
          userQuestion: user_question,
          kbQuestion: kb_question,
          kbAnswer: kb_answer
        }]
      }
    )

    case response.code
    when 204
      'Success!'
    else
      response.code
    end
  end

  def publish_kb
    response = HTTP.headers(
      'Ocp-Apim-Subscription-Key' => @subscription_key
    ).put(full_url(:publish_kb))

    case response.code
    when 204
      'Success!'
    else
      response.code
    end
  end

  private

  def full_url(method)
    endpoint = case method
               when :generateAnswer
                 'generateAnswer'
               when :train_kb
                 'train'
               when :update_kb, :publish_kb
                 ''
               else
                 ''
               end
    "#{BASE_URL}/#{@knowledgebase_id}/#{endpoint}"
  end

  def normalize(text)
    text
    .gsub("\r", '')
    .gsub('&lt;', '<')
    .gsub('&gt;', '>')
    .gsub('&#39;', "'")
    .gsub('&quot;', '"')
    .gsub('&amp;', '&')
  end
end
