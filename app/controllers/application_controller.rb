class ApplicationController < ActionController::API

  # returns object and status code on bad request
  def show_invalid_response(object)
    payload = { message: object[:message] }
    render json: payload, status: object[:status]
  end

  # checks the required parameters and raises exception if conditions doest not match
  def required(params, *lst)
    blanks = lst - lst.reject {|x| params[x] == "" or params[x].nil? }
    if blanks.empty?
      parameters = lst.map {|x| params[x] }
      parameters.count == 1 ? parameters.first : parameters
    else
      raise "Fields cannot be empty #{blanks}"
    end
  end

end
