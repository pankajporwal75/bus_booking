class Admin < User
  default_scope {where(role: :admin)}
end
