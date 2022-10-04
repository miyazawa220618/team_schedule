class Time < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '0.5h' },
    { id: 3, name: '1h' },
    { id: 5, name: '1.5h' },
    { id: 6, name: '2h' },
    { id: 7, name: '2.5h' },
    { id: 8, name: '3h' },
    { id: 9, name: '4h' },
    { id: 10, name: '5h' },
    { id: 11, name: '6h' },
    { id: 12, name: '7h' },
    { id: 13, name: '8h' },
    { id: 14, name: '9h' },
    { id: 15, name: '10h' }
  ]

  include ActiveHash::Associations
  has_many :shares
end