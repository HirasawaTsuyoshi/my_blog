class PostsController < ApplicationController
  before_action :set_post,only:[ :show,:edit,:update,:destroy]
  def index
    @q     = Post.order(created_at: :desc).ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(2)
    @new_posts = Post.find_newest_article
  end

  def show
    # @post = Post.find(params[:id])
  end

  def new
    #インスタンス変数にPostの空を渡す
    #フォーム用の空のインスタンスを生成する。
    #新規でモデルにデータを渡すので、空がないとダメだよね？
    #なので空の型を用意しておく
    @post = Post.new
  end

  def create
    #インスタンス変数に空枠（ストロングパラメータから取得した値が引数）を渡す
    #ストロングパラメータを引数に（post_params　は下記に）
    @post = Post.new(post_params)
    #saveをしてデータベースに保存する。
    @post.save
    #showページにリダイレクト
    redirect_to "/posts/#{@post.id}"
    # redirect_to @past
  end

  def edit
    # @post = Post.find(params[:id])
  end

  def update
    #URLからIDを取得して今ある更新前のデータを取得してインスタンス変数にセット
    #UPDATEの場合は、すでにモデルにあるデータを更新するので、どのIDかを取得した結果をインスタンス変数に入れておく
    # @post = Post.find(params[:id])
    # インスタンス変数をUPDATE
    # 何の項目を更新するかは、post_paramsに設定してある
    @post.update(post_params)
    # 更新が終わったら画面移動
    redirect_to "/posts/#{@post.id}"
  end

  def destroy
    # @post = Post.find(params[:id])
    @post.destroy
    redirect_to "/posts"
  end

  private

  def post_params # ストロングパラメータを定義する
    # @postに値を入れてくけど、何を入れるのかを明示的にしておかないとダメだよね？
    params.require(:post).permit(:title, :body, :category)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
