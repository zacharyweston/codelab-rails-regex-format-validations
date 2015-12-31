describe Post, type: :model do

  it { should validate_presence_of(:title)   }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:name)    }

  %i( title content ).each do |attribute|
    %w( a e i o u |_| ).each do |vowel|
      ([''] + %w( er ing )).each do |suffix|
        %i( downcase upcase ).each do |transformation|
          context %(when the #{attribute} contains a #{transformation}d version of "fl#{vowel}rb#{suffix}") do
            it %(raises a validation error about using the word "flurb") do
              flurb_variation = "fl#{vowel}rb#{suffix}".send(transformation)
              post = Post.new(attribute => flurb_variation)
              expect( post.errors_on(attribute) ).to include(%(can't include the word "flurb" or a variation thereof))
            end
          end
        end
      end
    end

    context %(when the #{attribute} does NOT contain "flurb" or a variation thereof) do
      it %(does NOT raise a validation error about using the word "flurb") do
        post = Post.new(attribute => 'flirt floorb flob clurb')
        expect( post.errors_on(attribute) ).not_to include(%(can't include the word "flurb" or a variation thereof))
      end
    end
  end

  [
    'Chris Fritz, Jr.',
    'George W. Bush',
    'Sarah Connor',
    'Lindsay',
    'blåbær, dèjá-vu',
    'Jürgen',
    '昨夜のコ トは最高で',
    'أحمد'
  ].each do |name|
    context "when the name is #{name}" do
      it %(does NOT raise a validation error complaining about the format) do
        post = Post.new(name: name)
        expect( post.errors_on(:name) ).not_to include(%(isn't a valid name (only letters, spaces, periods, dashes, and commas allowed)))
      end
    end
  end

  %w(
    0 1 2 3 4 5 6 7 8 9 ` ! @ # $ % ^ & * ( ) _ = + ; ? ˂ ˃ ˄ ˅ ˔ ˕ ˖ ˗ ˘ ˙ ˚ ˛ ˜ ˝ ˞ ˟ ˥ ˦ ˧ ˨ ˩ ˪ ˫ ˭ ˯ ˰ ˱ ˲ ˳ ˴ ˵ ˶ ˷ ˸ ˹ ˺ ˻ ˼ ˽ ˾ ˿  ́  ̂  ̃  ̄  ̅  ̆  ̇  ̈  ̉  ̊  ̋  ̌  ̍  ̎  ̏  ̐  ̑  ̒  ̓  ̔  ̕  ̖  ̗  ̘  ̙  ̚  ̛  ̜  ̝  ̞  ̟  ̠  ̡  ̢  ̣  ̤  ̥  ̦  ̧  ̨  ̩  ̪  ̫  ̬  ̭  ̮  ̯  ̰  ̱  ̲  ̳  ̴  ̵  ̶  ̷  ̸  ̹  ̺  ̻  ̼
  ).map do |special_character|
    word = ('a'..'z').to_a.shuffle[0,20].join
    word[ rand(20) ] = special_character
    word
  end.each do |name|
    context "when the name is #{name}" do
      it %(raises a validation error complaining about the format) do
        post = Post.new(name: name)
        expect( post.errors_on(:name) ).to include(%(isn't a valid name (only letters, spaces, periods, dashes, and commas allowed)))
      end
    end
  end

end
