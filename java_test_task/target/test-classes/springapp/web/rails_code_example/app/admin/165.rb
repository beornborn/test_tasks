ActiveAdmin.register BfComment, :as => "Comments for NewsWorthyentitys" do
    filter :body
    filter :anonymous, :as => :check_boxes
  actions   :index, :edit, :show, :update, :new, :create, :destroy
  index do
    column :body
    column :anonymous
    column(:user_id)  do |post|
        User.find(post.user_id).user_name 
    end
    default_actions
  end

  show do
    attributes_table do
      row :body
      row :anonymous
      row "User" do
        User.find(comments_for_news_worthy_entitys.user_id).user_name
      end
    end
  end

  form do |f|
    f.inputs "Member Details" do
      f.input :body
      f.input :anonymous
    end
    f.buttons
  end
end
