#
# ProductClass
#
# @author [Joice]
#

class Product < ActiveRecord::Base
  require 'roo'
  require 'creek'
  belongs_to :category
  has_many :offers
  paginates_per 3
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: '/images/noimage.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  def self.import_creek(file)
    creek = Creek::Book.new "/home/qbuser/Desktop/products_xlsx.xlsx"
    creek.sheets.each do |sheet|
      header = sheet.rows.first
      sheet.rows.each do |row, v|
        unless row.first.second == 'name'
          row = Hash[[header.values, row.values].transpose]
          product = Product.new(row)
          product.save!
        end
      end
    end
  end

  def self.search(search)
    if search
      where('name like ?', "#{search}%")
    else
      all
    end
  end

  def avatar_url
    avatar.url(:thumb)
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    allowed_attributes = ["id","name","category_id","unit_price","quantity","avatar"]
    spreadsheet = open_spreadsheet(file)
    p spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path, {})
    when '.xls' then Roo::Excel.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path, {})
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end

