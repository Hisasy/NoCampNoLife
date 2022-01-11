require 'rails_helper'

describe '会員ログイン前のテスト' do
  describe 'トップページのテスト' do
    before do
      visit '/'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end
end

describe 'ログインしていない場合のヘッダーのテスト' do
    before do
      visit '/'
    end

    context '表示内容のリンク先が正しいか' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ロゴリンクを押したらトップページに戻る' do
        page.first(".header-title").click
        expect(current_path).to eq '/'
      end
      it '新規登録ボタンのリンクが表示される' do
        expect(page).to have_link '新規登録', href: '/users/sign_up'
      end
      it 'ログインボタンのリンクが表示される' do
        expect(page).to have_link 'ログイン', href: '/users/sign_in'
      end
    end
end


describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '新規会員登録と表示されている' do
        expect(page).to have_content '新規会員登録'
      end
      it 'ユーザーネームフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it '住所フォームが表示される' do
        expect(page).to have_field 'user[address]'
      end
      it 'パスワードフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'パスワード確認用が表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '登録するボタンが表示される' do
        expect(page).to have_button '登録する'
      end
      it 'ログインページへののリンクが表示される' do
        expect(page).to have_link 'ログイン', href: '/users/sign_in'
      end
    end

    context '新規登録の送信に成功した際の処理' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[address]', with: Faker::Address
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '登録するボタンを押したら、登録できるか' do
        expect { click_button '登録する' }.to change(User.all, :count).by(1)
      end
      it '新規登録ボタンを押した後の、リダイレクト先は正しいか' do
        click_button '登録する'
        expect(current_path).to eq "/"
      end
    end
end

describe 'ユーザログインのテスト' do
    let(:user) { create(:user) }

    context '表示内容の確認' do
      before do
        visit new_user_session_path
      end

      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワードフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインするボタンが表示される' do
        expect(page).to have_button 'ログインする'
      end
      it '新規会員登録ページへののリンクが表示される' do
        expect(page).to have_link '新規会員登録', href: '/users/sign_up'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: 'password'
        click_button 'ログインする'
      end

      it 'ログイン後のリダイレクト先がトップページになっている' do
        expect(current_path).to eq "/"
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'
      end

      it 'ログインに失敗しログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end

    describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end

    it 'ログアウト後のリダイレクト先がログインページになっている' do
      click_link 'ログアウト'
      expect(current_path).to eq "/users/sign_in"
    end
  end

end