##
# class to manage list of contacts
#
class Contacts

  ##
  # create a Contacts object from string of pipe delimited ("|") fields, one record per line
  # e.g. "Brandon Faloona|Seattle|WA|bfaloona@uw.edu\nBarack Obama|Washington|DC|president@wh.gov"
  #
  def initialize data
    @raw_entries = data.split("\n")
    # set @contacts to an array of contacts
    @contacts = @raw_entries.collect do |line|
      contact_hash line
    end
  end

  def raw_entries
    @raw_entries
  end

  ##
  # the list of fields expected in input lines
  #
  def fields
    [:full_name, :city, :state, :email]
  end

  ##
  # create a contact (a hash) from raw input line
  #
  def contact_hash line
    values = line.split("|")
    Hash[fields.zip values]
  end

  ##
  # return a comma separated list of formatted email addresses
  #
  def email_list
    @raw_entries.collect do |line|
      name, city, state, email = line.split("|")
      format_email_address name, email.chomp
    end.join(", ")
  end

  ##
  # returns "Display Name" <email@address> given name and email
  #
  def format_email_address name, email
    %{"#{name}" <#{email}>}
  end

  def num_entries
    @raw_entries.length
  end

  def contact index
    @contacts[index.to_i]
  end

  #########

  def format_contact contact
    #@raw_entries
    #contact %{\"#{:full_name}, of #{:city}, #{:state}\" <#{:email}>}
    #Hash[%{#{:full_name}, :city]}
    #{}%{#{contact}}
    #contact_hash %{#{name}}
    #contact.map { |contact| contact[:full_name]}
    #contact.values %{\"#{:full_name}\" of \"#{:city}\"}
    #contact.keys
    #contact.values %{\"#{:full_name} of #{:city} #{:state}\" <#{:email}>}
    #{ |contact| %s of %s %s <#{:email}> % [:full_name, :city, :state]}
    #{}%{"Brandon Faloona of Seattle WA" <bfaloona@uw.edu>}
    #contact = %{{|contact|[:full_name]} "of" {contact[:city]}}
    %{"#{contact[:full_name]} of #{contact[:city]} #{contact[:state]}" <#{contact[:email]}>}
  end

  def all
    @contacts
  end

  def formatted_list
    truck_string = ""
    @contacts.each{|x|
    truck_string += format_contact(x) + "\n"
    }
    truck_string.chomp
  end

  def full_names
    truck_array = Array.new
    @contacts.each{|x|
    truck_array << x[:full_name]
    }
    truck_array
  end

  def cities
    truck_array = Array.new
    @contacts.each{|x|
    truck_array << x[:city]
    }
    truck_array.uniq
  end

  def append_contact contact
    @contacts << contact
  end

  def delete_contact index
    @contacts.delete_at(index)
  end

  def search string
    #truck_array = Array.new
    #@contacts.each{|x| if x.include? string then truck_array << x[string]} 
    #truck_array
    @contacts.map do |x| if x.include?(string) ; x end
  end

  def all_sorted_by field
    @contacts.sort {|x,y| x[field] <=> y[field]}
  end
  
end