def find_user(term)
  @user_find_model ||=
      Object.const_get(%w(Character User Person).detect { |name| Object.const_defined? name })

  @user_find_method ||=
    %w(login name).detect do |name|
      @user_find_model.column_names.include?(name)
    end
    
  @user_find_model.send("find_by_#{@user_find_method}", term)

end