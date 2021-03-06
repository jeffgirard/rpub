require 'spec_helper'

describe Rpub::Epub::HtmlToc do
  let(:outline) { [] }
  let(:book)    { double('book', :outline => outline) }
  let(:subject) { described_class.new(book).render }

  it { should have_xpath('/div/h1[text()="Table of Contents"]') }
  it { should have_xpath('/div/div[@class="toc"]') }

  context 'without headings in the outline' do
    it { should_not have_xpath('//a') }
  end

  context 'with heading in the outline' do
    let(:outline) { [['foo.html', [double('heading', :text => 'link', :html_id => 'bar', :level => 1)]]] }
    it { should have_xpath('/div/div/div[@class="level-1"]/a[@href="foo.html#bar"][text()="link"]') }
  end
end
