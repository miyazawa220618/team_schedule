class Hour < ActiveHash::Base
  self.data = [
    { id: 1,  name: '---' },
    { id: 5,  name: '0.5h' },
    { id: 10,  name: '1h' },
    { id: 15,  name: '1.5h' },
    { id: 20,  name: '2h' },
    { id: 25,  name: '2.5h' },
    { id: 30,  name: '3h' },
    { id: 40,  name: '4h' },
    { id: 50,  name: '5h' },
    { id: 60, name: '6h' },
    { id: 70, name: '7h' },
    { id: 80, name: '8h' },
    { id: 90, name: '9h' },
    { id: 100, name: '10h' }
  ]

  include ActiveHash::Associations
  has_many :shares
end