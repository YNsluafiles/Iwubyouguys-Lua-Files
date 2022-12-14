-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
	--table.concat(spell_maps,['Scop\'s Operetta']='Operetta')
	--table.concat(spell_maps,['Puppet\'s Operetta']='Operetta')

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	
	
	
    brd_daggers = S{'Kali', 'Tauret',}
	--'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri', 'Sabebus'}
    pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Blurred Harp +1'
    -- How many extra songs we can keep from Daurdabla/Terpander -2 with daura
    info.ExtraSongs = 1 
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')

	send_command('bind end gs c cycle CastingMode')
	--Custom Dummy song mappings. We're not likely going to ever need these songs.
	spell_maps['Scop\'s Operetta']='Operetta'
	spell_maps['Puppet\'s Operetta']='Operetta'
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    gear.capes = {}
	gear.capes.MAcc = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	gear.capes.TP  = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10'}}

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {head='Nahtriah hat', ear1="Enchanter earring +1", ear2="Loquac. Earring",
        body="Inyanga Jubbah +2", hands="Gendewitha Gages +1", ring1="Prolix Ring", ring2="Kishar ring", 
        back=gear.capes.MAcc,waist="Witful Belt",legs="Ayanmo Cosciales +2",feet="Chelona Boots"}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.BardSong = set_combine(sets.precast.FC,{
        main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
		sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		range="Gjallarhorn",
		body="Brioso Justaucorps +3", head="Fili Calot +1",neck="Aoidos' Matinee",ear1="Aoidos' Earring",
    	legs="Gendewitha Spats +1", feet="Bihu Slippers +3"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, {range='Marsyas'})
	
    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +2"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Bard's Charm",
    waist="Windbuffet Belt",
    left_ear="Suppanomimi",
    right_ear="Musical Earring",
    left_ring="Ayanmo Ring",
    right_ring="Rajas Ring",
    back=gear.capes.TP}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS)

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS)

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS)
    
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC
        
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
    sets.midcast.Lullaby = {hands="Brioso Cuffs +3"}
    sets.midcast.Madrigal = {head="Fili Calot +1"}
    sets.midcast.March = {hands="Fili Manchettes +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Etude = {head="Mousai Turban +1"}
    sets.midcast.Paeon = {}
    sets.midcast.Carol = {head="Fili Calot +1",
        body="Fili Hongreline +1",hands="Fili Manchettes +1",
        legs="Fili Rhingrave +1",feet="Fili Cothurnes +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
    --sets.midcast['Magic Finale'] = {neck="Mnbw. Whistle +1",waist="Corvax Sash",legs="Fili Rhingrave +1"}

    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
		main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
		sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		range="Gjallarhorn",
        head="Fili Calot +1",neck="Moonbow Whistle",
        body="Fili Hongreline +1",hands="Fili Manchettes +1",
        back=gear.capes.MAcc, legs="Inyanga Shalwar +2",feet="Brioso Slippers +2"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.SongEffect,{range='Marsyas'});
	
	sets.midcast.Minne = set_combine(sets.midcast.SongEffect,{})
    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
		main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
		sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		range="Gjallarhorn",
		head="Brioso Roundlet +3",
		body="Inyanga Jubbah +2",
		hands="Brioso Cuffs +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Demonry Sash",
		left_ear="Hermetic Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}
	sets.midcast["Horde Lullaby"] = set_combine(sets.midcast.SongDebuff, {range= 'Daurdabla'})
	sets.midcast["Horde Lullaby II"] = set_combine(sets.midcast["Horde Lullaby"], {})
	    sets.midcast['Magic Finale'] = set_combine(sets.midcast.SongDebuff,{})
	-- main="Lehbrailg +2",sub="Mephitis Grip",range="Gjallarhorn",
        -- head="Brioso Roundlet +1",neck="Aoidos' Matinee",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        -- body="Fili Hongreline +1",hands="Fili Manchettes +1",ring1="Prolix Ring",ring2="Sangoma Ring",
        -- back="Kumbira Cape",waist="Goading Belt",legs="Marduk's Shalwar +1",feet="Brioso Slippers +3 +1"}

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = sets.midcast.SongDebuff
	
	-- main="Lehbrailg +2",sub="Mephitis Grip",range="Gjallarhorn",
        -- head="Brioso Roundlet +1",neck="Wind Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        -- body="Brioso Justaucorps +1",hands="Fili Manchettes +1",ring1="Prolix Ring",ring2="Sangoma Ring",
        -- back="Kumbira Cape",waist="Demonry Sash",legs="Brioso Cannions +1",feet="Bokwus Boots"}

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear2="Loquacious Earring",
		ring1="Prolix Ring",
        back=gear.capes.Macc,waist="Corvax Sash",legs="Fili Rhingrave +1"}

    sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})
	
    -- Cast spell with normal gear, except using Daurdabla instead
  --  sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})
	sets.midcast.Operetta = sets.midcast.DaurdablaDummy

    -- Other general spells and classes.
    sets.midcast.Cure = {}
        
    sets.midcast.Curaga = sets.midcast.Cure
        
    sets.midcast.Stoneskin = {}
        
    sets.midcast.Cursna = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Bihu Roundlet +3",
		body="Bihu Justaucorps +3",
		hands="Bihu Cuffs +3",
		legs="Brioso Cannions +3",
		feet="Bihu Slippers +3",
		neck="Bard's Charm",
		waist="Flume Belt",
		left_ear="Loquac. Earring",
		right_ear="Musical Earring",
		left_ring="Moonbeam Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
	}

    sets.idle.PDT = {
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Bihu Roundlet +3",
		body="Bihu Justaucorps +3",
		hands="Bihu Cuffs +3",
		legs="Brioso Cannions +3",
		feet="Bihu Slippers +3",
		neck="Bard's Charm",
		waist="Flume Belt",
		left_ear="Loquac. Earring",
		right_ear="Musical Earring",
		left_ring="Moonbeam Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
	}
	
    sets.idle.Town = set_combine(sets.idle,{main="Kali",range="Gjallarhorn",
        feet="Fili Cothurnes +1"})
    
    sets.idle.Weak = {}
    
    
    -- Defense sets

    sets.defense.PDT = sets.idle.PDT

    sets.defense.MDT = set_combine(sets.idle,{
	main='Rhadamanthus', sub='Mafic Cudgel',
	head='Inyanga Tiara +2',
	body='Inyanga Jubbah +2',
	hands='Inyanga Dastanas +2',
	legs='Inyanga Shalwar +2',
	feet='Inyanga Crackows +2', ring1='Inyanga Ring'})

    sets.Kiting = {feet="Fili Cothurnes +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {    
	sub="Aeneas",
	main="Tauret",
	range= 'Daurdabla',
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Bard's Charm",
    waist="Windbuffet Belt",
    left_ear="Suppanomimi",
    right_ear="Brutal Earring",
    left_ring="Ayanmo Ring",
    right_ring="Rajas Ring",
    back=gear.capes.TP}

    -- Sets with weapons defined.
    sets.engaged.Dagger = {   
	range= 'Daurdabla',
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Bard's Charm",
    waist="Windbuffet Belt",
    left_ear="Suppanomimi",
    right_ear="Brutal Earring",
    left_ring="Ayanmo Ring",
    right_ring="Rajas Ring",
    back=gear.capes.TP}

    -- Set if dual-wielding
    sets.engaged.DW = {
	sub="Atoyac",
	main="Rhadamanthus",
	range= 'Daurdabla',
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Bard's Charm",
    waist="Windbuffet Belt",
    left_ear="Suppanomimi",
    right_ear="Brutal Earring",
    left_ring="Ayanmo Ring",
    right_ring="Rajas Ring",
    back=gear.capes.TP}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end

        state.ExtraSongsMode:reset()
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.interrupted then
        if spell.target and spell.target.type == 'SELF' then
            adjust_timers(spell, spellMap)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    pick_tp_weapon()
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
	if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
	if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.11 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
	if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.13 end
	
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Fili Calot +1" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == "Fili Manchettes +1" then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Fili Rhingrave +1" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Fili Cothurnes +1" then mult = mult + 0.1 end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
    
    local totalDuration = math.floor(mult*120)

    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
        if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 1)
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
