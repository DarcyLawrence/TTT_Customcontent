AddCSLuaFile()

SWEP.HoldType              = "ar2"

sound.Add({
	name = 			"Weapon_Carbine.Single",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		"carbine.ogg",
	level = 600
})

if CLIENT then
   SWEP.PrintName          = "Soviet Carbine"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 70

   SWEP.Icon               = "vgui/ttt/icon_m16"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_RIFLE

SWEP.Primary.Delay         = 0.40
SWEP.Primary.Recoil        = 4
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "357"
SWEP.Primary.Damage        = 34
SWEP.Primary.Cone          = 0.005
SWEP.Primary.ClipSize      = 10
SWEP.Primary.ClipMax       = 20
SWEP.Primary.DefaultClip   = 10
SWEP.Primary.Sound         = "Weapon_Carbine.Single"
SWEP.HeadshotMultiplier    = 3.4

SWEP.Primary.Penetration   = 32

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_357_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/soviet_carbine/soviet_carbine.mdl"
SWEP.WorldModel            = "models/weapons/soviet_carbine/w_soviet_carbine.mdl"

SWEP.IronSightsPos         = Vector(-4.15, -5, 3)
SWEP.IronSightsAng         = Vector(-4.9, -2.2, -2.1)

function SWEP:SetZoom(state)
   if not (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer()) then return end
   if state then
      self:GetOwner():SetFOV(40, 0.5)
   else
      self:GetOwner():SetFOV(0, 0.2)
   end
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
   if not self.IronSightsPos then return end
   if self:GetNextSecondaryFire() > CurTime() then return end

   local bIronsights = not self:GetIronsights()

   self:SetIronsights( bIronsights )

   self:SetZoom( bIronsights )

   self:SetNextSecondaryFire( CurTime() + 0.3 )
end

function SWEP:PreDrop()
   self:SetZoom(false)
   self:SetIronsights(false)
   return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
    if (self:Clip1() == self.Primary.ClipSize or
        self:GetOwner():GetAmmoCount(self.Primary.Ammo) <= 0) then
       return
    end
    self:DefaultReload(ACT_VM_RELOAD)
    self:SetIronsights(false)
    self:SetZoom(false)
end

function SWEP:Holster()
   self:SetIronsights(false)
   self:SetZoom(false)
   return true
end
