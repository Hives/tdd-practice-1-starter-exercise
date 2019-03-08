# TDD skills workshop

<https://github.com/makersacademy/skills-workshops>

## Exercise 1

Apply the 'imagine how to use it' strategy for this brief:

> As a student  
> So that I can remember people's names  
> I want an IRB application that stores the names of people I meet

```
> remember_name("Billy")
=> 'Name "Billy" remembered!'
> remember_name("Sally")
=> 'Name "Sally" remembered!'
> get_names
=> ['Billy', 'Sally']
```

## Exercise 2

Apply the 'imagine how to use it' strategy for this brief:

> As a student
> So that I can understand my recent motivation
> I want an IRB application that stores my motivation ratings
> And I want to see the average of my last 3 ratings

```
> track_motivation(3)
=> "Motivation stored!"
> track_motivation(5)
=> "Motivation stored!"
> track_motivation(2)
=> "Motivation stored!"
> recent_motivation
=> "Average of last three motivations: 3.3"
```

## Exercise 3

Once you've been through the 'imagine how to use it' process for a brief, it's easy to turn your steps into tests. I applied this theory to the steps I wrote in exercise 1:

```ruby
describe "the remember_name method" do
  it "gives us a confirmation message" do
    expect(remember_name("Billy")).to eq 'Name "Billy" remembered!'
  end
end
```

## Exercise 4

I initialised RSpec and pasted the test above into `spec/remember_names_spec.rb`. Running `rspec` then gave the following error:

```ruby
tdd-skills-workshop on  master
➜ rspec
F

Failures:

  1) the remember_name method gives us a confirmation message
     Failure/Error: expect (remember_name("Billy")).to eq 'Name "Billy" remembered!'

     NoMethodError:
       undefined method `remember_name' for #<RSpec::ExampleGroups::TheRememberNameMethod:0x00007f91b91dda88>
     # ./spec/track_motivation_spec.rb:3:in `block (2 levels) in <top (required)>'

Finished in 0.00437 seconds (files took 0.18996 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/track_motivation_spec.rb:2 # the remember_name method gives us a confirmation message
```

## Exercise 5

We want to make the smallest possible change to the code which will make the tests pass. The strategy is called **race to green**.

The error message for our test says:

```ruby
NoMethodError:
    undefined method `remember_name' for ...
```

The minimal code that will satisfy this is:

```ruby
def remember_name
end
```

So we add this to `lib/remember_names.rb`, `require` it in the test spec file, and re-run the tests. Now we get this error:

```ruby
tdd-skills-workshop on  master [✘?]
➜ rspec
F

Failures:

  1) the remember_name method gives us a confirmation message
     Failure/Error:
       def remember_name
       end

     ArgumentError:
       wrong number of arguments (given 1, expected 0)
     # ./lib/remember_names.rb:1:in `remember_name'
     # ./spec/remember_names_spec.rb:5:in `block (2 levels) in <top (required)>'

Finished in 0.00254 seconds (files took 0.11904 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/remember_names_spec.rb:4 # the remember_name method gives us a confirmation message
```

In other words we've stopped the previous error happening, but we're getting a new one - the test is passing 1 argument to the method, but it is expecting to receive 0. So we update our code:

```ruby
def remember_name(name)
end
```

Run `rspec` again and we get this errorr:

```ruby
tdd-skills-workshop on  master
➜ rspec
F

Failures:

  1) the remember_name method gives us a confirmation message
     Failure/Error: expect(remember_name("Billy")).to eq 'Name "Billy" remembered!'

       expected: "Name \"Billy\" remembered!"
            got: nil

       (compared using ==)
     # ./spec/remember_names_spec.rb:5:in `block (2 levels) in <top (required)>'

Finished in 0.01617 seconds (files took 0.12277 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/remember_names_spec.rb:4 # the remember_name method gives us a confirmation message
```

So the test was expecting the method to return a particular string but got `nil`. The smallest change we can make to satisfy this test is:

```ruby
def remember_name(name)
  'Name "Billy" remembered!'
end
```

Run `rspec` again:

```ruby
tdd-skills-workshop on  master [!]
➜ rspec
.

Finished in 0.00536 seconds (files took 0.20767 seconds to load)
1 example, 0 failures
```

W00t! 😎

This program is still fairly useless though, so let's write another test to force us to update it:

```ruby
describe "the remember_name method" do
  it "gives us a confirmation message about 'Billy' when receiving argument 'Billy'" do
    expect(remember_name("Billy")).to eq 'Name "Billy" remembered!'
  end
  it "gives us a confirmation message about 'Sally' when receiving argument 'Sally'" do
    expect(remember_name("Sally")).to eq 'Name "Sally" remembered!'
  end
end
```

Tests now fail, so let's update our method:

```ruby
def remember_name(name)
    "Name \"#{name}\" remembered!"
end
```

Tests now pass.

## Exercise X

That's the end of the exercises, but we haven't got very far in terms of satisfying the original brief in [exercise 1](#exercise-1), so what would we do next?

- Add a test that the `get_names` method exists
- Add the method to pass the test
- Add a test that the `get_names` method returns an empty array
- Update the `get_names` method to return an empty array
- Add a test goes through these steps:
  - `remember_name("Billy")`
  - `get_names` should now return `["Billy"]`
- Update code:
  - create an instance variable `@names` outside the methods, initialised to an empty array.
  - update `remember_name` to add the given name to `names`
  - update `get_names` to return the array

At this point the tests should pass and we will have met the brief.

Ok, I just tried doing this and ran into a problem - RSpec won't initialise an instance variable defined outside of the methods. Way around this would be to bundle it all into a class or something...