require 'json'

class DisbursementsRepository
  def self.create(disbursement, source = './dataset/disbursements.json')
    file = File.read(source)
    json = JSON.parse(file)
    updated_content = json
    updated_content['RECORDS'] << disbursement.to_h

    File.open(source, 'w') do |f|
      f.puts JSON.pretty_generate(updated_content)
    end
  end

  def self.all(source = './dataset/disbursements.json')
    file = File.read(source)
    JSON.parse(file)['RECORDS']
  end
end
