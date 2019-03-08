@names = []

def remember_name(name)
    @names << name
    "Name '#{name}' remembered!"
end

def get_names
    @names
end