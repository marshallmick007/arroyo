require "spec_helper"

describe Arroyo::Url do
  describe 'create' do
    it "creates a valid url from a plain string" do
      u = Arroyo::Url.create("test")
      expect(u.ok?).to be true
    end

    it "creates a valid url from a plain domain" do
      u = Arroyo::Url.create("test.com")
      expect(u.ok?).to be true
    end

    it "creates a valid url from a www.domain" do
      u = Arroyo::Url.create("www.domain.tld")
      expect(u.ok?).to be true
    end

    it "creates a valid url from a domain with http scheme" do
      u = Arroyo::Url.create("http://test.com")
      expect(u.ok?).to be true
    end

    it "creates a valid url from a domain with https scheme" do
      u = Arroyo::Url.create("https://test.com")
      expect(u.ok?).to be true
    end

    it "does not create a domain with a nil" do
      u = Arroyo::Url.create(nil)
      expect(u.ok?).to be false
    end

    it "does not create a domain with an empty string" do
      u = Arroyo::Url.create("")
      expect(u.ok?).to be false
    end


    it "does not create a domain with an Integer" do
      u = Arroyo::Url.create(1)
      expect(u.ok?).to be false
    end
  end

  describe 'host' do
    it "has host for plain string" do
      u = Arroyo::Url.create("test")
      expect(u.host).to eq("test")
    end

    it "has host for plain domain" do
      u = Arroyo::Url.create("test.com")
      expect(u.host).to eq("test.com")
    end

    it "has host from a www.domain" do
      u = Arroyo::Url.create("www.domain.tld")
      expect(u.host).to eq("www.domain.tld")
    end

    it "has host from a domain with http scheme" do
      u = Arroyo::Url.create("http://test.com")
      expect(u.host).to eq("test.com")
    end

    it "creates a valid url from a domain with https scheme" do
      u = Arroyo::Url.create("https://test.com")
      expect(u.host).to eq("test.com")
    end
    
    it "has a nil host for invalid Url" do
      u = Arroyo::Url.create(nil)
      expect(u.host).to be nil
    end
  end

  describe 'remove_www' do
    it "creates a new instance for valid Url" do
      u = Arroyo::Url.create("www.domain.tld")
      expect(u.remove_www).not_to be u
    end
    
    it "returns the same instance for invalid Url" do
      u = Arroyo::Url.create(nil)
      expect(u.remove_www).to be u
    end
    
    it "removes 'www' from beginning of host" do
      u = Arroyo::Url.create('www.test.com')
      uw = u.remove_www
      expect(u.host).to eq('www.test.com')
      expect(uw.host).to eq('test.com')
    end
    
    it "doesn't remove 'www' from middle of host" do
      u = Arroyo::Url.create('subwww.test.com')
      uw = u.remove_www
      expect(u.host).to eq('subwww.test.com')
      expect(uw.host).to eq('subwww.test.com')
    end

  end

  describe 'tld' do

  end

end
