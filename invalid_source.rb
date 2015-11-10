class InvalidSource < Exception
  def message
    "That is not a valid source. Please choose from the following: \n#{Source.names.join("\n")}"
  end
end
