require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do
  before do
    klass = @solution.constant
    @obj = klass.new
  end
  
  spec("should return PL"){@obj.find_country_by_ip('83.29.122.34').should == 'PL'}
  spec("should return US"){@obj.find_country_by_ip('68.97.89.187').should == 'US'}
  spec("should return RU"){@obj.find_country_by_ip('80.79.64.128').should == 'RU'}
  spec("should return EU"){@obj.find_country_by_ip('192.189.119.1').should == 'EU'}
  spec("should return JP"){@obj.find_country_by_ip('210.185.128.123').should == 'JP'}
  spec("should return ZZ"){@obj.find_country_by_ip('255.0.0.1').should == 'ZZ'}
end
