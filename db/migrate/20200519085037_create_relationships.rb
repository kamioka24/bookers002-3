class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      # 中間テーブルだからカラムは t.references で作らなくてはならない。モデルと同時に作らない。
      t.references :user , foreign_key: true
      t.references :follow, foreign_key: { to_table: :users } #参照先はuserテーブルにしたいので to_table: :users
      # なぜ :user と :follow に_idは要らないのか。

      t.timestamps

      t.index [:user_id, :follow_id], unique: true
      # ペアで重複するものが保存されないようにする設定。何度も同じユーザーをフォローできないようにする。
    end
  end
end
