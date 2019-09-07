class StaticPagesController < ApplicationController
  def about
    @button_text = Goal.count >= 1 ? 'Back to my goats' : 'Get started'
  end
end
