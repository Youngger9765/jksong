class ScoreService

  categories = Category.pluck(:english_name) << 'total'

  categories.each do |category|
    define_method("#{category}_score") do |argument|
      argument.to_a.sum(&category.to_sym)
    end
  end

end