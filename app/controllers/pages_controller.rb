class PagesController < ApplicationController
  def home
  end

  def teamtotals
  	 if user_signed_in?
      if current_admin_user
        @finances_grid = initialize_grid(Finance,
          :include => [:user])
        @total_cash = Finance.sum("cash_amount")
        @total_check = Finance.sum("check_amount")
        @total_amount = @total_cash + @total_check

        @india_total_cash = 0
        @india_total_check = 0
        @japan_total_cash = 0
        @japan_total_check = 0
        @nicaragua_total_cash = 0
        @nicaragua_total_check = 0
        @uganda_total_cash = 0
        @uganda_total_check = 0
        @china_total_cash = 0
        @china_total_check = 0

        @leader_total_cash = 0
        @leader_total_check = 0

        @all_leader_indexes = []

        User.all.each do |user|
          #puts in all leaders index
          if user.admin == true
            @all_leader_indexes << user.id
          end
          if user.team == "india"
            @india_total_cash += user.finances.sum("cash_amount")
            @india_total_check += user.finances.sum("check_amount")
          elsif user.team == "japan"
            @japan_total_cash += user.finances.sum("cash_amount")
            @japan_total_check += user.finances.sum("check_amount")
          elsif user.team == "nicaragua"
            @nicaragua_total_cash += user.finances.sum("cash_amount")
            @nicaragua_total_check += user.finances.sum("check_amount")
          elsif user.team == "uganda"
            @uganda_total_cash += user.finances.sum("cash_amount")
            @uganda_total_check += user.finances.sum("check_amount")
          elsif user.team == "china"
            @china_total_cash += user.finances.sum("cash_amount")
            @china_total_check += user.finances.sum("check_amount")
          end
        end
        @india_total_amount = @india_total_check + @india_total_cash
        @japan_total_amount = @japan_total_check + @japan_total_cash
        @nicaragua_total_amount = @nicaragua_total_check + @nicaragua_total_cash
        @uganda_total_amount = @uganda_total_check + @uganda_total_cash
        @china_total_amount = @china_total_check + @china_total_cash
        #works with leaders being "Admins"
        for i in @all_leader_indexes
          @leader_total_cash += User.find(i).finances.sum("cash_amount")
          @leader_total_check += User.find(i).finances.sum("check_amount")
        end
        @leader_total_amount = @leader_total_cash + @leader_total_check
      end
    end
  end
end
