# frozen_string_literal: true

module TaiwanIdValidator
  UBN_WEIGHTS = [1, 2, 1, 2, 1, 2, 4, 1].freeze
  LETTER_WEIGHTS = {
    'A' => 10, 'B' => 11, 'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15, 'G' => 16,
    'H' => 17, 'J' => 18, 'K' => 19, 'L' => 20, 'M' => 21, 'N' => 22, 'P' => 23,
    'Q' => 24, 'R' => 25, 'S' => 26, 'T' => 27, 'U' => 28, 'V' => 29, 'X' => 30,
    'Y' => 31, 'W' => 32, 'Z' => 33, 'I' => 34, 'O' => 35
  }.freeze

  NATIONAL_ID_REGEX = /^[A-Z][12]\d{8}$/.freeze
  NEW_ARC_ID_REGEX = /^[A-Z][89]\d{8}$/.freeze
  OLD_ARC_ID_REGEX = /^[A-Z][A-Z]\d{8}$/.freeze
  UBN_REGEX = /^\d{8}$/.freeze

  module_function

  # valid? checks if the given ID is a valid Taiwan National ID or Alien Resident Certificate number.
  def valid?(id)
    id = id.to_s.upcase
    if NATIONAL_ID_REGEX.match?(id) || NEW_ARC_ID_REGEX.match?(id)
      validate_modern_id_card_format(id)
    elsif OLD_ARC_ID_REGEX.match?(id)
      validate_old_arc_id_format(id)
    else
      false
    end
  end

  # ValidateNationId checks if the given ID is a valid Taiwan National ID.
  def valid_national_id?(id)
    id = id.to_s.upcase
    return false unless NATIONAL_ID_REGEX.match?(id)

    validate_modern_id_card_format(id)
  end

  # valid_arc_id? checks if the given ID is a valid Taiwan Alien Resident Certificate number.
  def valid_arc_id?(id)
    id = id.to_s.upcase
    if NEW_ARC_ID_REGEX.match?(id)
      validate_modern_id_card_format(id)
    elsif OLD_ARC_ID_REGEX.match?(id)
      validate_old_arc_id_format(id)
    else
      false
    end
  end

  # valid_ubn? checks if the given UBN is a valid Taiwan Company Tax ID.
  def valid_ubn?(ubn)
    ubn = ubn.to_s
    return false unless UBN_REGEX.match?(ubn)
    return false if ubn == "00000000"

    sum1 = 0
    sum2 = 0

    UBN_WEIGHTS.each_with_index do |weight, i|
      digit = ubn[i].to_i
      if i == 6 && digit == 7
        sum1 += 1
        sum2 += 0
      else
        product = digit * weight
        sum1 += (product / 10) + (product % 10)
        sum2 += (product / 10) + (product % 10)
      end
    end

    (sum1 % 5).zero? || (sum2 % 5).zero?
  end

  class << self
    private

    def validate_modern_id_card_format(id)
      sum = 0
      
      area_char = id[0]
      area_weight = LETTER_WEIGHTS[area_char]
      return false unless area_weight

      sum += (area_weight / 10) * 1 + (area_weight % 10) * 9
      
      weights = [8, 7, 6, 5, 4, 3, 2, 1]
      
      id[1..8].chars.each_with_index do |char, i|
        num = char.to_i
        sum += num * weights[i]
      end

      check_digit = id[9].to_i
      sum += check_digit

      (sum % 10).zero?
    end

    def validate_old_arc_id_format(id)
      sum = 0
      
      area_char = id[0]
      area_weight = LETTER_WEIGHTS[area_char]
      return false unless area_weight

      sum += (area_weight / 10) * 1 + (area_weight % 10) * 9
      
      gender_char = id[1]
      gender_weight = LETTER_WEIGHTS[gender_char]
      return false unless gender_weight
      
      sum += (gender_weight % 10) * 8
      
      weights = [7, 6, 5, 4, 3, 2, 1]
      
      id[2..8].chars.each_with_index do |char, i|
        num = char.to_i
        sum += num * weights[i]
      end

      check_digit = id[9].to_i
      sum += check_digit

      (sum % 10).zero?
    end
  end
end
