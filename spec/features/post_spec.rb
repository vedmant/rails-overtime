require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create :user }
  let(:post) { FactoryGirl.create :post, user: user }

  before do
    login_as(user, :scope => :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      post1 = FactoryGirl.create :post, user: user
      post2 = FactoryGirl.create :second_post, user: user
      visit posts_path
      expect(page).to have_content(/Some Rationale/)
    end

    it 'has a scope so that only post creators can see their posts' do
      other_user = FactoryGirl.create :non_authorized_user
      post_from_other_user = FactoryGirl.create :post_from_other_user, user: other_user

      visit posts_path

      expect(page).to_not have_content(/Post from other user/)
    end
  end


  describe 'new' do

    it 'has a link from the homepage' do
      visit root_path
      click_link('new_post_form_nav')
      expect(page.status_code).to eq(200)
    end

  end


  describe 'delete' do

    it 'can be deleted' do
      post_to_delete = FactoryGirl.create :post, user: user
      visit posts_path
      click_link("delete_post_#{post_to_delete.id}_from_index")
      expect(page.status_code).to eq(200)
    end

  end


  describe 'creation' do
    before do
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some rationale'
      fill_in 'post[overtime_request]', with: 1.5

      expect { click_on 'Save' }.to change(Post, :count).by(1)
    end

    it 'will have user associated it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'User_Association'
      fill_in 'post[overtime_request]', with: 1.5
      click_on 'Save'

      expect(User.last.posts.last.rationale).to eq('User_Association')
    end
  end


  describe 'edit' do
    it 'can be edited' do
      visit edit_post_path(post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Edited content'
      click_on 'Save'

      expect(page).to have_content 'Edited content'
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      login_as(non_authorized_user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end
end