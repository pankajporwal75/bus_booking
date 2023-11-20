class AddConfirmableToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :unconfirmed_email, :string
    add_column :users, :otp, :string
    add_column :users, :otp_sent_at, :datetime
  end
end
