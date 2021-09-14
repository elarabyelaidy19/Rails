class CatRentalRequest < ApplicationRecord 

  STATUS_STATS = %w(APPROVED DENIED PENDING).freeze 

  validates :status, :start_date, :end_date, presence: true  
  validates :status, inclusion: STATUS_STATS 
  
  belongs_to :cat 

  def overlapping_requests 
    CatRentalRequest 
      .where(id: self.id ) 
      .where.not(cat_id: cat_id) 
      .where.not('start_date > :end_date OR end_date < :start_date ', 
                  start_date: start_date, end_date: end_date ) 
  end 

  
  def overlapping_approved_requests 
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_requests 
    return if self.status == 'DENIED'

    if overlapping_approved_requests.any?
      errors[:cat] << "request cannot be processed"
    end
  end

  def overlapping_pending_requests 
    overlapping_requests.where(status: 'PENDING')
  end

  def approve!
    CatRentalRequest.transaction do 
      self.status = 'APPROVED'
      self.save!

      overlapping_pending_requests.each do |request| 
        request.status = 'DENIED'
        request.save! 
      end
    end
  end 

  def deny!
    self.status = 'DENIED' 
    self.save!
  end

  def pending? 
    self.status == 'PENDING' 
  end

end
