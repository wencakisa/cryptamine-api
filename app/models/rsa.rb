require 'prime'

class Rsa < ApplicationRecord
  has_many :encrypted_messages
  has_many :decrypted_messages

  validates_presence_of :n, :e, :d

  E = 655_37
  DELIMITER = '-'.freeze
  RAND_RANGE = 2**5..2**8

  def self.new_keys
    p = generate_random_prime RAND_RANGE
    q = generate_random_prime RAND_RANGE
    n = p * q
    d = calculate_private p, q, E

    { n: n, e: E, d: d }
  end

  def encrypt(message)
    message.chars.map(&:ord).map(&method(:encryption_formula)).join DELIMITER
  end

  def decrypt(message)
    message
      .split(DELIMITER)
      .map(&:to_i)
      .map(&method(:decryption_formula))
      .map(&:chr)
      .join
  end

  private

  class << self
    def generate_random_prime(range)
      Prime.take(rand(range)).last
    end

    def extended_gcd(a, b)
      return [0, 1] if (a % b).zero?

      x, y = extended_gcd b, a % b
      [y, x - y * (a / b)]
    end

    def phi(a, b)
      (a - 1) * (b - 1)
    end

    def calculate_private(p, q, e)
      t = phi p, q
      x, = extended_gcd e, t
      x += t if x < 0
      x
    end
  end

  def pow_mod(number, power, modulo)
    number**power % modulo
  end

  def encryption_formula(number)
    pow_mod number, e, n
  end

  def decryption_formula(number)
    pow_mod number, d, n
  end
end
