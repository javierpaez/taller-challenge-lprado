require "test_helper"

class BookTest < ActiveSupport::TestCase
  test 'fail validations without required data' do
    book = Book.new

    assert_not book.valid?
    assert_equal book.errors.messages, {
      title: ["can't be blank"],
      author: ["can't be blank"],
      publication_date: ["can't be blank"],
    }
  end

  test 'pass validation with correct data' do
    book = Book.new(
      title: 'Foo',
      author: 'John Doe',
      publication_date: Date.today,
    )

    assert book.valid?
    assert_empty book.errors.messages
  end

  test 'fail validation if rating is not a number' do
    book = Book.new(
      title: 'Foo',
      author: 'John Doe',
      publication_date: Date.today,
      rating: 'Foo'
    )

    assert_not book.valid?
    assert_equal book.errors.messages, {
      rating: ['is not a number']
    }
  end

  test 'fail validation if rating is not between 0 and 5' do
    book = Book.new(
      title: 'Foo',
      author: 'John Doe',
      publication_date: Date.today,
      rating: 10
    )

    assert_not book.valid?
    assert_equal book.errors.messages, {
      rating: ['is not included in the list']
    }
  end

  test 'fail validation if status is not on the list' do
    book = Book.new(
      title: 'Foo',
      author: 'John Doe',
      publication_date: Date.today,
      status: :foo
    )

    assert_not book.valid?
    assert_equal book.errors.messages, {
      status: ['is not included in the list']
    }
  end
end
