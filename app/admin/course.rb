ActiveAdmin.register Course do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	index do 
		id_column
		column :title
		column :description
		column :created_at 
		actions
	end

	permit_params :image, :trailer, :title, :description, category_ids:[]
 	
 	form do |f|
 		inputs "Novo Couse" do
	 		f.input :image
	 		f.input :trailer
	 		f.input :title
	 		f.input :description
	 		f.input :categories
	 		f.actions
	 	end
 	end

end