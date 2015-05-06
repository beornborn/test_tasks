ActiveAdmin.register PollQuestion do
  filter :adress
  filter :created_at
   actions   :index, :edit, :show, :update, :new, :create, :destroy
  index do
    column :adress
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs "Member Details" do
      f.input :adress
    end
    f.buttons
  end
end
