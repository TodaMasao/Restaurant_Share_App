class Restaurant < ApplicationRecord

  # アソシエーション
  has_many :MarkRestaurant,primary_key: 'gurunavi_id', foreign_key: 'gurunavi_id'
  has_many :WentRestaurant,primary_key: 'gurunavi_id', foreign_key: 'gurunavi_id'
  has_many :User, through: :MarkRestaurant

  # 定数
  RESTAURANT_ACCER_ZERO = 0

  # accessor
  attr_accessor :mark_restaurant_current_user_reg, :went_restaurant_current_user_reg, :score_avg, :score, :mark_restaurant_count, :went_restaurant_count

  # [概　要] ぐるなびのレストラン検索APIのレスポンスパラメータからrestaurant配列を取得
  # [引　数] ぐるなび レストラン検索APIレスポンスパラメータ(json)
  # [戻り値] Restaurant配列
  # [説　明] 引数のパラメータより飲食店情報を取得し、restaurant配列として返す
  def self.get_gurunavi_params_restaurants_arg(params)
    restaurants = []
    params = params[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_REST]

    params.each do |param|
      restaurant = Restaurant.new
      restaurant.gurunavi_id = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_ID]
      restaurant.category = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_CATEGORY]
      restaurant.name = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_NAME]
      restaurant.address = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_ADDRESS]
      restaurant.image_url = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_IMAGE_URL][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_IMAGE_SHOP_IMAGE1]
      restaurant.opentime = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_OPENTIME]
      restaurant.holiday = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_HORIDAY]
      restaurant.pr_short = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_PR][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_PR_SHORT]
      restaurant.tel = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_NAME_TEL]
      restaurant.gurunavi_url = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_URL]
      restaurant.access_line = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_LINE]
      restaurant.access_station = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_STATION ]
      restaurant.access_station_exit = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_STATION_EXIT]
      restaurant.access_walk = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_WALK]
      restaurant.access_note = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS][Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_ACCESS_NOTE]
      restaurant.budget = param[Gurunavi::GURUNAVI_RESTAURANT_SEARCH_PARAM_GURUNAVI_BUDGET]

      restaurants << restaurant
    end
    restaurants
  end

  # [概　要] Restaurantオブジェクトのハッシュパラメータからrestaurantインスタンスを取得
  # [引　数] Restaurantオブジェクトのハッシュパラメータ
  # [戻り値] Restaurant配列
  # [説　明] 引数のパラメータよりrestaurant情報を取得し、restaurantインスタンスを返す
  def self.get_param_restaurant(params)
    restaurant = Restaurant.new
    restaurant.gurunavi_id = params[:gurunavi_id]
    restaurant.category = params[:category]
    restaurant.name = params[:name]
    restaurant.address = params[:address]
    restaurant.image_url = params[:image_url]
    restaurant.opentime = params[:opentime]
    restaurant.holiday = params[:holiday]
    restaurant.pr_short = params[:pr_short]
    restaurant.tel = params[:tel]
    restaurant.gurunavi_url = params[:gurunavi_url]
    restaurant.access_line = params[:access_line]
    restaurant.access_station = params[:access_station]
    restaurant.access_station_exit = params[:access_station_exit]
    restaurant.access_walk = params[:access_walk]
    restaurant.access_note = params[:access_note]
    restaurant.budget = params[:budget]

    restaurant
  end

  private

  # [概　要] Restaurantオブジェクトのaccessorに値を代入する
  # [引　数] Restaurantオブジェクト(配列 or 単体), ユーザID
  # [戻り値] Restaurant配列
  # [説　明] Restaurantオブジェクトのscoreにmark_restaurantのscore平均をセットする
  def self.set_accessor(restaurant_org, user_id, current_user_id = user_id)

    if Array == restaurant_org.class 
      # 引数が配列型の場合
      restaurants = []
      restaurant_org.each do |restaurant|
        restaurant = set_accessor_get_model_value(restaurant, user_id, current_user_id)
        restaurants << restaurant
      end
      restaurants
    else
      # 上記以外の場合
      restaurant = set_accessor_get_model_value(restaurant_org, user_id, current_user_id)
      restaurant
    end
  end

  # [概　要] set_accessorの作業用メソッド Restaurantオブジェクトのaccessorに値を代入する(modelからの値取得処理)
  # [引　数] Restaurantオブジェクト,ユーザID,カレントユーザID
  # [戻り値] Restaurantオブジェクト
  # [説　明] Restaurantオブジェクトのaccerssorに値をセットする
  def self.set_accessor_get_model_value(restaurant, user_id, current_user_id)

    # restaurantのgurunavi_idがMarkRestaurantテーブルに登録有無されているかどうか
    if MarkRestaurant.exists?(gurunavi_id: restaurant.gurunavi_id)
      restaurant.score_avg = MarkRestaurant.where(gurunavi_id: restaurant.gurunavi_id).average(:score)
      restaurant.mark_restaurant_count = Follow.joins(:mark_restaurant).where(user_id: current_user_id, mark_restaurants:{gurunavi_id: restaurant.gurunavi_id}).count(:gurunavi_id)
      restaurant.mark_restaurant_count +=1 if MarkRestaurant.exists?(user_id: current_user_id, gurunavi_id: restaurant.gurunavi_id)

    else
      restaurant.score_avg = RESTAURANT_ACCER_ZERO
      restaurant.mark_restaurant_count = RESTAURANT_ACCER_ZERO
    end
    
    # ユーザがmark_restaurantにgurunavi_idを登録しているかどうか
    if MarkRestaurant.exists?(user_id: user_id, gurunavi_id: restaurant.gurunavi_id)
      restaurant.score = MarkRestaurant.find_by(user_id: user_id, gurunavi_id: restaurant.gurunavi_id).score
    else
      restaurant.score = RESTAURANT_ACCER_ZERO
      restaurant.mark_restaurant_count = RESTAURANT_ACCER_ZERO
    end

    # カレントユーザがmark_restaurantにgurunavi_idを登録しているかどうか
    if MarkRestaurant.exists?(user_id: current_user_id, gurunavi_id: restaurant.gurunavi_id)
      restaurant.mark_restaurant_current_user_reg = true
    else
      restaurant.mark_restaurant_current_user_reg = false
    end

    # ユーザがwent_restaurantにgurunavi_idを登録しているかどうか
    if WentRestaurant.exists?(user_id: user_id, gurunavi_id: restaurant.gurunavi_id)
      restaurant.went_restaurant_count = Follow.joins(:went_restaurant).where(user_id: current_user_id, went_restaurants:{gurunavi_id: restaurant.gurunavi_id}).count(:gurunavi_id)
      restaurant.went_restaurant_count +=1 if WentRestaurant.exists?(user_id: current_user_id, gurunavi_id: restaurant.gurunavi_id)
    else
      restaurant.went_restaurant_count = RESTAURANT_ACCER_ZERO
    end

    # カレントユーザがwent_restaurantにgurunavi_idを登録しているかどうか
    if WentRestaurant.exists?(user_id: current_user_id, gurunavi_id: restaurant.gurunavi_id)
      restaurant.went_restaurant_current_user_reg = true
    else
      restaurant.went_restaurant_current_user_reg = false 
    end

    restaurant
  end
end