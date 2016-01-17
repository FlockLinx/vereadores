module PolitiansHelper

  def tag_result_class(result)
    if ["2", "3"].include?(result.tse_id)
      "success"
    elsif ["5"].include?(result.tse_id)
      "warning"
    elsif ["4", "-1"].include?(result.tse_id)
      "danger"
    end
  end
end
