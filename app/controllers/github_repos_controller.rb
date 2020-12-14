class GithubReposController < ApplicationController  
  def query
    # Simple test to show the parameters are being picked up correctly
    # render json: {params: "#{params[:lang]}, #{params[:user]}, #{params[:popularity]}"}
    response = HTTParty.get("https://api.github.com/search/repositories?q=language:#{params[:lang]}&order=desc", {
      headers: {"Accept" => "application/vnd.github.preview.text-match+json"},
    })
    # Response is currently just a string. We need to turn it into a hash, so we can more easily work with it. HTTParty has a method just for that:
    response = response.parsed_response

    logger.info("Found #{response['total_count']} repositories written in the #{params[:lang]} language")
    
    # At any point in the code, we can open a debugger to better see what's the current state.
    # byebug

    result = response['items'].select do |item|
      item['owner']['login'] == params[:user] && item['stargazers_count'] >= params[:popularity].to_i
    end
    render json: result
  end

  private
  def query_params
    # lang is missing. Why? When we added it as a parameter in routes.rb, it was the same as requiring it. 
    params.require(:user).permit(:popularity)
  end
end
