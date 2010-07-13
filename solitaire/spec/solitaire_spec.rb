require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @instance = klass.new
  end
  
  spec "should decrypt message A" do
    @instance.encrypt('YOURC IPHER ISWOR KINGX').should == 'CLEPK HHNIY CFPWH FDFEH'
    @instance.decrypt('CLEPK HHNIY CFPWH FDFEH').should == 'YOURC IPHER ISWOR KINGX'
  end

  spec "should decrypt message B" do
    @instance.encrypt('WELCO METOR UBYQU IZXXX').should == 'ABVAW LWZSY OORYK DUPVH'
    @instance.decrypt('ABVAW LWZSY OORYK DUPVH').should == 'WELCO METOR UBYQU IZXXX'
  end

  spec "should encrypt/decrypt a more complicated message" do
    @instance.encrypt('In David Kahn\'s book Kahn on Codes, he describes a real pencil-and-paper cipher used by a Soviet spy').should == 'MKNYD HVQEO HFUWE FFSFX OMZNL HHDWP AKXXV ALNIW WTMNU HJQQP VEQDU WKJQB RONMD HDFXQ KEEBY ZHMYD'
    @instance.decrypt('MKNYD HVQEO HFUWE FFSFX OMZNL HHDWP AKXXV ALNIW WTMNU HJQQP VEQDU WKJQB RONMD HDFXQ KEEBY ZHMYD').should == 'INDAV IDKAH NSBOO KKAHN ONCOD ESHED ESCRI BESAR EALPE NCILA NDPAP ERCIP HERUS EDBYA SOVIE TSPYX'
  end
  
end
