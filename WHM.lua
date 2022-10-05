-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
    main="Seveneyes",
    ammo="Impatiens",
    head="Welkin Crown",
    body="Inyanga Jubbah +2",
    hands="Gendewitha Gages",
    legs="Aya. Cosciales +2",
    feet="Theophany duckbills +2",
    neck="aceso's choker +1",  --Phalaina locket-- --orison locket--
    waist="Witful Belt",
    left_ear="Magnetic earring",	
    right_ear="Loquac. Earring",
    left_ring="Lebeche ring",
    right_ring="Kishar ring", --Prolix ring--
    back="Swith Cape",
	}
    
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash",legs="Ebers duckbills"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat",legs="Ebers duckbills",neck="Nodens Gorget"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +2",feet="Vanya Clogs",main="Yagrush"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
    main="Queller Rod",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Theophany Cap +2",
    body="Inyanga Jubbah +2",
    hands="Gendewitha Gages",
    legs="Ebers Pantaloons +2",
    feet="Vanya Clogs",
    neck="aceso's choker +1",  --aceso's choker +1--
    waist="Witful Belt",
    left_ear="Nourishing earring +1",
    right_ear="Loquac. Earring",
    left_ring="Lebeche Ring",
    right_ring="Prolix Ring",
    back="Swith Cape"})
	
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    
    -- Job Abilities
    sets.precast.JA['Benediction'] = {body="Piety Briault +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",ear1="Roundel Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    --gear.default.weaponskill_neck = "Fotia Gorget"
   -- gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {}
    
    sets.precast.WS['Flash Nova'] = {}
	
	
    ------------------------------------------------------------------ Midcast Sets ------------------------------------------------------------------
	-- This is the gear that you want to be in by the time you finish your spellcasting. 
	--------------------------------------------------------------------------------------------------------------------------------------------------	
	
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Dynasty Mitts",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    -- Cure sets
    gear.default.obi_waist = "Goading Belt"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {
    main="Queller Rod",
    sub="Sors Shield",
    ammo="White tathlum",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +2",
    legs="Ebers Pantaloons +2",
    feet="Vanya Clogs",
    neck="Aceso's choker +1",
    waist="Pythia Sash",
    left_ear="Nourishing earring +1",
    right_ear="Glorious earring",
    left_ring="Lebeche Ring",
    right_ring="Sirona's Ring",
    back={ name="Alaunus's Cape"},}

    sets.midcast.Cure = {
    main="Queller Rod",
    sub="Sors Shield",
    ammo="White tathlum",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +2",
    legs="Ebers Pantaloons +2",
    feet="Vanya Clogs",
    neck="Phalaina locket",  --aceso's choker +1--
    waist="Pythia Sash",
    left_ear="Nourishing earring +1",
    right_ear="Glorious earring",
    left_ring="Lebeche ring",
    right_ring="Sirona's Ring",
    back={ name="Alaunus's Cape"},}

    sets.midcast.Curaga = {
    main="Queller Rod",
    sub="Sors Shield",
    ammo="White tathlum",
    head="Ebers Cap +1",
    body="Theophany Briault +3",
    hands="Theophany Mitts +2",
    legs="Ebers Pantaloons +2",
    feet="Vanya Clogs",
    neck="Aceso's choker +1",
    waist="Pythia Sash",
    left_ear="Nourishing Earring +1",
    right_ear="Glorious earring",
    left_ring="Lebeche ring",
    right_ring="Sirona's Ring",

    back={ name="Alaunus's Cape"},}

    sets.midcast.CureMelee = {
    main="Queller Rod",
	sub="Genmei Shield",
    ammo="Mana Ampulla",
    head="Vanya Hood",
    body="Ebers Bliaud",
    hands="Inyan. Dastanas +1",
    legs="Ebers Pantaloons +2",
    feet="Piety Duckbills +2",
    neck="Nodens Gorget",
    waist="Pythia Sash +1",
    left_ear="Glorious Earring",
    right_ear="Magnetic Earring",
    left_ring="Stikini Ring +1",
    right_ring="Sirona's Ring",
    back={ name="Alaunus's Cape"},}

	--na/erase
    sets.midcast.StatusRemoval = {main="Yagrush", legs="Ebers Pantaloons +2", neck="Cleric's Torque"}

	sets.midcast.Cursna = {
    main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    legs="Theophany Pantaloons +2",
    feet="Vanya Clogs",
    neck="Cleric's Torque",
    waist="Pythia Sash",
    left_ear="Glorious earring",
    right_ear="Magnetic Earring",
    left_ring="Sirona's Ring",
    right_ring="Ephedra Ring",
    back={ name="Alaunus's Cape"},}

	sets.midcast.Erase = {
    main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    legs="Theophany Pantaloons +2",
    feet="Vanya Clogs",
    neck="Cleric's Torque",
    waist="Pythia Sash",
    left_ear="Glorious earring",
    right_ear="Magnetic Earring",
    left_ring="Sirona's Ring",
    right_ring="Ephedra Ring",
    back={ name="Alaunus's Cape"},}
	
	sets.midcast.Blindna = {
    main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    legs="Theophany Pantaloons +2",
    feet="Vanya Clogs",
    neck="Cleric's Torque",
    waist="Pythia Sash",
    left_ear="Glorious earring",
    right_ear="Magnetic Earring",
    left_ring="Sirona's Ring",
    right_ring="Ephedra Ring",
    back={ name="Alaunus's Cape"},}
	
	sets.midcast.Paralyna = {
    main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    legs="Theophany Pantaloons +2",
    feet="Vanya Clogs",
    neck="Cleric's Torque",
    waist="Pythia Sash",
    left_ear="Glorious earring",
    right_ear="Magnetic Earring",
    left_ring="Sirona's Ring",
    right_ring="Ephedra Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','"Cure" potency +10%','Damage Taken -5%'}}}
	
	sets.midcast.Silena = {
    main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    legs="Theophany Pantaloons +2",
    feet="Vanya Clogs",
    neck="Cleric's Torque",
    waist="Pythia Sash",
    left_ear="Glorious earring",
    right_ear="Magnetic Earring",
    left_ring="Sirona's Ring",
    right_ring="Ephedra Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','"Cure" potency +10%','Damage Taken -5%'}}}
	
	sets.midcast.Poisona = {
    main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    legs="Theophany Pantaloons +2",
    feet="Vanya Clogs",
    neck="Cleric's Torque",
    waist="Pythia Sash",
    left_ear="Glorious earring",
    right_ear="Magnetic Earring",
    left_ring="Sirona's Ring",
    right_ring="Ephedra Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','"Cure" potency +10%','Damage Taken -5%'}}}
	
	sets.midcast.Stona = {
    main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    legs="Theophany Pantaloons +2",
    feet="Vanya Clogs",
    neck="Cleric's Torque",
    waist="Pythia Sash",
    left_ear="Glorious earring",
    right_ear="Magnetic Earring",
    left_ring="Sirona's Ring",
    right_ring="Ephedra Ring",
    back={ name="Alaunus's Cape"},}
	
	sets.midcast.Viruna = {
    main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head="Ebers cap +1",
    body="Ebers Bliaud +1",
    hands="Fanatic Gloves",
    legs="Theophany Pantaloons +2",
    feet="Vanya Clogs",
    neck="Cleric's Torque",
    waist="Pythia Sash",
    left_ear="Glorious earring",
    right_ear="Magnetic Earring",
    left_ring="Sirona's Ring",
    right_ring="Ephedra Ring",
    back={ name="Alaunus's Cape"},}
	
    sets.midcast['Enhancing Magic'] = {
    main="Seveneyes",
    ammo="Impatiens",
    head="Befouled crown",
    body="Ebers Bliaud +1",
    hands="Dynasty Mitts",
    legs="Piety pantaloons +2",
    feet="Ebers duckbills", --Theophany duckbills +2--
    neck="Enhancing Torque",
    waist="Olympus Sash",
    left_ear="Augmenting earring",
    right_ear="Andoaa earring",
    left_ring="Prolix Ring",
    right_ring="Lebeche Ring",
    back={ name="Alaunus's Cape"},}

    sets.midcast.Stoneskin = {
        ear2="Magnetic Earring",
        hands="Dynasty Mitts",
        back="Swith Cape",waist="Siegel Sash"}

    sets.midcast.Auspice = {
	hands="Dynasty Mitts",
	legs="Ebers duckbills"}

    sets.midcast.BarElement = {
    main="Seveneyes",
    sub="Sors Shield",
    ammo="White tathlum",
    head="Befouled Crown",
    body="Ebers Bliaud +1",
    hands="Inyan. Dastanas +2",
    legs="Piety Pantaloons +2",
    feet="Theophany Duckbills +2",
    neck="Enhancing Torque",
    waist="Olympus Sash",
    left_ear="Augmenting Earring",
    right_ear="Andoaa Earring",
    back={ name="Alaunus's Cape"},}

    sets.midcast.Regen = {
    main="Bolelabunga",
    sub="Sors Shield",
    ammo="White Tathlum",
    head="Inyanga Tiara +2",
    body="Piety briault +3",
    hands="Ebers Mitts +1",
    legs="Theophany pantaloons +2",
    feet="Theophany duckbills +2",
    neck="Cleric's Torque",
    waist="Pythia sash",
    left_ear="Augmenting Earring",
    right_ear="Magnetic Earring",
    back={ name="Alaunus's Cape"},}

	sets.midcast.Refresh = {waist="Gishdubar Sash"}

    sets.midcast.Protectra = {feet="Piety Duckbills +1"}

    sets.midcast.Shellra = {legs="Piety Pantaloons"}


    sets.midcast['Divine Magic'] = {main="Yagrush",sub="Culminus",
        head="Inyanga tiara +2",neck="Henic Torque",ear1="Gwati Earring",ear2="Magnetic Earring",
        body="Inyanga jubbah +2",hands="Inyanga Dastanas +2",ring2="Adoulin ring",
        back="Felicitas Cape +1",legs="Ayanmo Cosciales +2",feet="Theophany duckbills +2"}

    sets.midcast['Dark Magic'] = {}
	
    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
    main="Yagrush",
    sub="Culminus",
    ammo="Leisure Musk +1",
    head="Befouled Crown",
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs="Ayanmo Cosciales +2",
    feet="Theophany duckbills +2",
    neck="Erra Pendant",
    waist="Pythia Sash",
    left_ear="Gwati Earring",
    right_ear="Magnetic Earring",
    left_ring="Lebeche Ring",
    right_ring="Adoulin ring",
    back="Felicitas cape +1"}

    sets.midcast.IntEnfeebles = {
    main="Yagrush",
    sub="Culminus",
    ammo="Leisure Musk +1",
    head="Befouled Crown",
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs="Ayanmo Cosciales +2",
    feet="Theophany duckbills +2",
    neck="Erra Pendant",
    waist="Pythia Sash",
    left_ear="Gwati Earring",
    right_ear="Magnetic Earring",
    left_ring="Lebeche Ring",
    right_ring="Adoulin ring",
    back="Felicitas cape +1"}

    

    ------------------------------------------------------------------ Idle Sets ------------------------------------------------------------------
	-- This is the gear you default back to after an action completes (assuming you're not engaged).
	--------------------------------------------------------------------------------------------------------------------------------------------------	
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff", 
        body="Piety Briault +3",head="Befouled Crown",hands="Nares Cuffs",
        waist="Hierach belt",legs="Lengo Pants",feet="Chelona Boots",back="Felicitas Cape +1"}
    

    -- Idle sets
    sets.idle = {
    main="Bolelabunga",
    sub="Sors Shield",
    ammo="Staunch Tathlum",
    head="Befouled Crown",
    body="Piety Briault +3",
    hands="Inyanga Dastanas +2",
    legs="Lengo Pants",
    feet="Herald's Gaiters",
    neck="Twilight Torque",
    waist="Witful Belt",
    left_ear="Novia Earring",
    right_ear="Loquac. Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Archon Ring",
    back="Mecistopins mantle"}

    sets.idle.PDT = 
	{main="Mafic Cudgel",
    sub="Sors Shield",
    ammo="Staunch Tathlum",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Twilight Torque",
    waist="Witful Belt",
    left_ear="Novia Earring",
    right_ear="Loquac. Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Archon Ring",
    back="Alaunus Cape"}

    sets.idle.Town = {
    ammo="Staunch Tathlum +1",}
    
    sets.idle.Weak = {}
    
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {}

    ------------------------------------------------------------------ Engaged Sets ------------------------------------------------------------------
	-- Gear you wanna wear while swinging at a mob.
	--------------------------------------------------------------------------------------------------------------------------------------------------	
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
    main="Yagrush",
    sub="Thorfinn shield +1",
    ammo="Jukukik Feather",
    head="Aya. Zucchetto +2", 
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Sanctity necklace",
    waist="Windbuffet Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn earring",
    left_ring="Rajas Ring",
    right_ring="Adoulin Ring",
    back="Kayapa cape"}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {main="Yagrush",hands="Ebers mitts +1",back="Mending Cape"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 2)
end

