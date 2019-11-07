# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_admin
    u = User.find_by(email: "admin@linkwok.com")
    if u.nil?
        u = User.create!(email: "admin@linkwok.com", password: "password", password_confirmation: "password")
        require 'faker'
        sbus = ["SBU1, SBU2"]
        units = ["Unit1", "Unit2", "Unit3"]
        departments = ["HR", "Admin", "Finance", "IT"]
        locations = ["Mumbai", "Pune", "Vadodara"]
        e = Employee.new
        e.emp_code = Faker::UniqueGenerator.clear
        e.name = Faker::Name.name
        e.email = Faker::Internet.email
        e.sbu = sbus.sample
        e.unit = units.sample
        e.department = departments.sample
        e.location = locations.sample
        e.user_id = u.id
        e.save!
    end
    role_master = RoleMaster.find_by(name: "admin")
    Role.create(user_id: u.id, role_master_id: role_master.id)
end

def create_role_masters
    roles = ["admin", "hr", "user", "l1", "l2", "chairman", "l1_rep", "l2_rep"]
    roles.each do |role|
        RoleMaster.create!(name: role)
    end
end

def create_award_masters
    awards = [
        {title: "The Best Cross-Functional Team", ratings: ["Inception", "Execution", "Documentation"]}, 
        {title: "The Most Inspiring Leader", ratings: ["Innovation","Agility","Customer Focus","Ownership","Performance Delivery","Responsiveness"]}, 
        {title: "The Best Employee", ratings: ["Productivity","Quality","Cost Delivery","Safety & Morale"]}, 
        {title: "The Most Innovative Employee", ratings: ["Ideation","Implementation Benefits","Replication","Documentation"]},
    ]
    awards.each do |award|
        am = AwardMaster.create!(title: award[:title], award_type: award[:title].underscore)
        award[:ratings].each do |rating|
            RatingScale.create(title: rating, award_master_id: am.id)
        end
    end
end

def create_employees
   20.times do |i|
        u = create_user
   end 
end

def create_user
    require 'faker'
    sbus = ["SBU1, SBU2"]
    units = ["Unit1", "Unit2", "Unit3"]
    departments = ["HR", "Admin", "Finance", "IT"]
    locations = ["Mumbai", "Pune", "Vadodara"]
    e = Employee.new
    e.emp_code = Faker::UniqueGenerator.clear
    e.name = Faker::Name.name
    e.email = Faker::Internet.email
    e.sbu = sbus.sample
    e.unit = units.sample
    e.department = departments.sample
    e.location = locations.sample
    u = User.create!(emp_code: e.emp_code, email: e.email, password: "password", password_confirmation: "password")
    e.user_id = u.id
    e.save!
    role_master = RoleMaster.find_by(name: "user")
    Role.create(user_id: u.id, role_master_id: role_master.id)
    u
end


create_award_masters
# create_role_masters
# create_admin
# create_employees