class Public::RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def confirm
    @request_lists = current_customer.request_lists.all #カート内アイテムの表示用変数
    total = 0 #合計金額用の変数
    @cart_items.each do |cart_items|
      total += cart_items.subtotal
    end
    @total_amount = total #合計金額用の変数
    @postage = 800 #送料800円の変数
    @pay_money = @total_amount + @postage #支払金額用の変数
    select_address = params[:order][:select_address] #ラジオボタン選択番号を検索
    if select_address == "0"
      # (「0」番の場合)ログインユーザーの住所
      @request = Order.new(order_params)
      @request.postal_code = current_customer.postal_code
      @request.address = current_customer.address
      @request.address_name = current_customer.last_name + current_customer.first_name
    else
      render :new
    end
  end

  def create
    # 注文(Order)モデルに注文を保存
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    if order.save
    # 注文詳細(OrderDetail)モデルにカート内商品の情報をもとに保存
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = cart_item.item.with_tax_price
        order_detail.amount = cart_item.amount
        order_detail.save
      end
    # カート内商品を全て削除
      current_customer.cart_items.destroy_all
    # 注文完了画面に遷移
      redirect_to thanx_orders_path
    else
      flash[:alert] = "注文失敗しました。"
      redirect_to cart_items_path
    end
  end

  def thanx
  end

  def index
    @requests = current_customer.requests.all
  end

  def show
    @request = Request.find(params[:id])
    @request_details = @request.request_details
  end

  private

  def request_params
    params.require(:request).permit(:pay_method, :postal_code, :address, :address_name, :postage, :pay_money)
  end
end
