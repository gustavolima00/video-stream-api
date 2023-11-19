ActiveAdmin.register Title do
  permit_params :name, :description, :kind

  index do
    column :name
    column :description
    column :kind
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :kind
      row :medias
    end
  end

  # Formulário para new e edit
  form do |f|
    f.inputs 'Title Details' do
      f.input :name
      f.input :description
      f.input :kind
    end
    f.actions
  end
end
