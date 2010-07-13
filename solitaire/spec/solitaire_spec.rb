require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @instance = klass.new
  end
  
  spec "should decrypt message A" do
    @instance.decrypt('CLEPK HHNIY CFPWH FDFEH').should == 'YOURC IPHER ISWOR KINGX'
  end

  spec "should decrypt message B" do
    @instance.decrypt('ABVAW LWZSY OORYK DUPVH').should == 'WELCO METOR UBYQU IZXXX'
  end
  
end
