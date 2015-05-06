ActiveAdmin.register Background do
    filter :id
    filter :active, :as => :check_boxes
    filter :counter, :label => 'Priority'
    filter :updated_at
  actions   :index, :edit, :show, :update, :new, :create, :destroy
  index do
    column :id 
    column :active
    column 'Priority', :counter
    column :resolution1024x768    
    column :resolution1152x864
    column :resolution1280x800
    column :resolution1280x1024
    column :resolution1366x768
    column :resolution1440x900
    column :resolution1600x900
    column :resolution1920x1080
    column :resolution2560x1440
    column :resolution2560x1920
    column :url
    column :updated_at
    default_actions
  end
  
  show do
    attributes_table do
      row :id 
      row :active
      row 'Priority' do
        background.counter
      end
      row :resolution1024x768    
      row :resolution1152x864
      row :resolution1280x800
      row :resolution1280x1024
      row :resolution1366x768
      row :resolution1440x900
      row :resolution1600x900
      row :resolution1920x1080
      row :resolution2560x1440
      row :resolution2560x1920
      row :url
      row :updated_at
    end
  end
  
  form do |f|
    f.inputs "Member Details" do
    f.input :active
    f.input :counter, :label => 'Priority'
    f.input :resolution1024x768
    f.input :resolution1152x864
    f.input :resolution1280x800
    f.input :resolution1280x1024
    f.input :resolution1366x768
    f.input :resolution1440x900
    f.input :resolution1600x900
    f.input :resolution1920x1080
    f.input :resolution2560x1440
    f.input :resolution2560x1920
    f.input :url
    end
    f.buttons
  end
end
