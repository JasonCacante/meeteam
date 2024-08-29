# frozen_string_literal: true

class Product < ApplicationRecord
  def self.paginate(page: 1, per_page: 10)
    page = page.to_i
    per_page = per_page.to_i
    offset = (page - 1) * per_page

    # Fetch records with limit and offset
    records = Product.limit(per_page).offset(offset)

    # Calculate total pages
    total_records = Product.all.count
    total_pages = (total_records / per_page.to_f).ceil

    OpenStruct.new(
      records:,
      current_page: page,
      per_page:,
      total_pages:,
      total_records:
    )
  end
end
