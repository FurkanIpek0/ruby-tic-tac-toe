module Question

  def self.question_ask(question, *correct_answers)
    loop do
      correct_answers = correct_answers.map { |answer| answer.to_s}
      puts question
      answer = gets.chomp.downcase
      return answer if correct_answers.include?(answer)
      puts "is Incorrect! Please try again."  
    end
  end

  def self.question_type_ask(question, type)
    loop do
      puts question
      answer = gets.chomp
      case type
      when "name"
        return answer if answer.match?(/\A[a-zA-Z0-9]{3,16}\z/)
      else
        puts "Invalid input. Please try again."
      end
    end
  end
end

