require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  describe "Home page" do
  	before { visit root_path }

  	it { should have_selector('h1', text: 'ANIPP') }
  	it { should have_selector('title', text: 'ANIPP') }
    
    #it "should have the h1 'ANIPP" do
    #	visit root_path
    #	page.should have_selector('h1', text: 'ANIPP')
    #end

    #it "should have the title 'ANIPP'" do
    #	visit root_path
    #	page.should have_selector('title', text: 'ANIPP')
    #end

  end
end
