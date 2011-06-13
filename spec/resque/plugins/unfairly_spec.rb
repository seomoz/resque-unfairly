require File.expand_path("../../spec_helper", File.dirname(__FILE__))

describe Resque::Plugins::Unfairly do
  it 'has the priorities set from Rankor::QUEUE_WEIGHTS' do
    described_class.instance_variable_get(:@priorities).should == Rankor::QUEUE_WEIGHTS
  end
  
  context 'with our own priorities' do
    before do
      described_class.instance_variable_set :@priorities, nil
    end

    describe 'queues' do
      let (:worker) { Resque::Worker.new(*queues) }
      let (:queues) { ['b','d','a','c'] }

      context 'under a Monte Carlo test' do

        let (:counts) { {'a' => 0, 'b' => 0, 'c' => 0, 'd' => 0} }

        before do
          priorities.each { |q,p| described_class.prioritize(q,p) }

          N = 100000
          N.times do
            counts[worker.queues_randomly_ordered.first] += 1 rescue begin ebug
          end
          counts.each do |k,v| # normalize
            counts[k] /= N.to_f
          end
        end

        context "with weights 4, 3, 2, 1" do
          let (:priorities) { { 'a' => 4, 'b' => 3, 'c' => 2, 'd' => 1 } }

          it 'makes the first queue returned probablistically proportional to the corresponding weights' do
            counts['a'].should > 0.38 and counts['a'].should < 0.42
            counts['b'].should > 0.28 and counts['b'].should < 0.32
            counts['c'].should > 0.18 and counts['c'].should < 0.22
            counts['d'].should > 0.08 and counts['d'].should < 0.12
          end
        end
        
        context "with weights 9, 1, 2, 0" do
          let (:priorities) { { 'a' => 9, 'b' => 1, 'c' => 2, 'd' => 0 } }

          it 'makes the first queue returned probablistically proportional to the corresponding weights' do
            counts['a'].should > 0.88 and counts['a'].should < 0.92
            counts['b'].should > 0.08 and counts['b'].should < 0.12
            counts['c'].should > 0.19 and counts['c'].should < 0.22
            counts['d'].should == 0
          end
        end

      end
      
      
      context 'when priorities is not set' do
        it 'consistenty gives the original order' do
          10.times do
            worker.queues_randomly_ordered.should == queues
          end
        end
      end
    end
  end
end
