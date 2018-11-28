require('pry')
require_relative('models/bounties.rb')

Bounty.delete_all()

bounty_1 = Bounty.new({
  'name' => 'Spike Spiegel',
  'bounty_value' => '1000000',
  'danger_level' => 'high',
  'last_location' => 'Titan',
  'homeworld' => 'Mars',
  'weapon' => 'pistol',
  'captured' => 'f',
  'collected_by' => 'null'
  })

bounty_2 = Bounty.new({
  'name' => 'Gellert Franz',
  'bounty_value' => '1000',
  'danger_level' => 'low',
  'last_location' => 'Tattoine',
  'homeworld' => 'Coruscant',
  'weapon' => 'blaster',
  'captured' => 't',
  'collected_by'  => 'Boba Fett'
  })

bounty_1.save()
bounty_2.save()

bounty_1.delete()

bounty_2.bounty_value = 2000000000
bounty_2.danger_level = 'Very High'
bounty_2.last_location = 'Naboo'
bounty_2.weapon = 'death star'
bounty_2.captured = false
bounty_2.collected_by = 'null'
bounty_2.update()

all_bounties = Bounty.all()

bounty_name_1 = Bounty.find_by_name('Gellert Franz')
bounty_name_2 = Bounty.find_by_name('Gellert Fonz')
bounty_id_1 = Bounty.find(2)
bounty_id_2 = Bounty.find(2000)


binding.pry()
nil
