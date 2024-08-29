# frozen_string_literal: true

class Product < ApplicationRecord
  def self.paginate(page: 1, per_page: 10, key: '', sort_by: 'created_at', sort_order: 'asc')
    # Validate the page parameter
    page = page.to_i
    per_page = per_page.to_i
    offset = (page - 1) * per_page

    allowed_sort_fields = %w[price created_at]
    sort_by = allowed_sort_fields.include?(sort_by) ? sort_by : 'created_at'
    sort_order = %w[asc desc].include?(sort_order) ? sort_order : 'asc'

    query = if key.present?
              Product.where('name ILIKE ? OR description ILIKE ?', "%#{key}%", "%#{key}%")
            else
              Product.all
            end

    total_records = query.count
    records = query.order("#{sort_by} #{sort_order}").limit(per_page).offset(offset)
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
