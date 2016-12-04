class ApplicationController < ActionController::API
  def show_response(status_code, object, message)
    render json: { status: status_code, data: object, message: message}
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
