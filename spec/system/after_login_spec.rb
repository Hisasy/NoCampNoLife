require 'rails_helper'

describe '会員ログイン後のテスト' do
  let(:user) { create(:user) }
  before do
    @post = FactoryBot.build(:post)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'
  end

  describe 'ログインしている場合のヘッダーのテスト※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
    context 'ヘッダーの表示内容が正しい' do
      it 'ロゴリンクを押したらトップページに戻る' do
        page.first(".header_title").click
        expect(current_path).to eq '/'
      end
      it 'マイページボタンのリンクが表示される' do
        expect(page).to have_link 'マイページ', href: '/users/' + user.id.to_s
      end
      it 'ログアウトボタンのリンクが表示される' do
        expect(page).to have_link 'ログアウト', href: '/users/sign_out'
      end
    end
  end

  describe '会員の詳細画面' do
    before do
      click_link 'マイページ'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it 'プロフィール編集ボタンのリンク先が正しい' do
        expect(page).to have_link '会員情報を編集する', href: '/users/' + user.id.to_s + '/edit'
      end
    end
  end

  describe '会員の情報編集ができているか' do
    before do
      visit edit_user_path(user)
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it 'ユーザーネームフォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]',with: user.name
      end
      it 'お住まいプルダウンが表示される' do
        expect(page).to have_field 'user[address]'
      end
      it '自己紹介フォームが表示される' do
        expect(page).to have_field 'user[introduction]',with: user.introduction
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'user[email]',with: user.email
      end
      it '画像の選択ボタンが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it 'プロフィール画像が表示される' do
        expect(page).to have_selector("img[src$='no_image.jpg']")
      end
      it 'プロフィールフォームと内容が表示される' do
        expect(page).to have_field 'user[profile]'
      end
      it '更新するボタンが表示される' do
        expect(page).to have_button '更新する'
      end
      it '退会するリンクが表示される' do
        expect(page).to have_link '退会する',href: '/users/quit'
      end
    end

    context '会員情報の変更に成功した際の処理' do
      before do
        @user_old_name = user.name
        @user_old_address = user.address
        @user_old_introduction = user.introduction
        @user_old_email = user.email
        @user_old_image = attach_file 'user[image]', "#{Rails.root}/spec/factories/images/no_image.jpg"
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[address]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 50)
        select "5", from: "user_address"
        attach_file 'user[image]', "#{Rails.root}/spec/factories/images/takibi.jpeg"
        click_button '更新する'
        end
# ここから
        it '名前が正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
        end
        it '住所が正しく更新される' do
        expect(user.reload.address).not_to eq @user_old_address
        end
        it '自己紹介が正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_introduction
        end
        it 'メールアドレスが正しく更新される' do
        expect(user.reload.email).not_to eq @user_old_email
        end
        it 'プロフィール画像が正しく更新される' do
        expect(user.reload.image).not_to eq @user_old_image
        end
        it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
        end
    end
  end

end