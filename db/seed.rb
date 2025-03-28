# db/seeds.rb

puts "Criando empresa 'Cassiano' com usuário administrador..."

company = Company.find_or_create_by!(
  name: "Cassiano",
  subdomain: "cassiano"
)

User.find_or_create_by!(
  email: "admin@cassiano.com",
  company: company
) do |user|
  user.password = "123456"
  user.password_confirmation = "123456"
  user.role = "superadmin" # se você tiver essa coluna
end

puts "Empresa e usuário criados com sucesso!"
