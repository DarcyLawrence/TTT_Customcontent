AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "Soviet Carbine"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_m16"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_RIFLE

SWEP.Primary.Delay         = 0.40
SWEP.Primary.Recoil        = 4
SWEP.Primary.Automatic     = false
SWEP.Primary.Ammo          = "357"
SWEP.Primary.Damage        = 34
SWEP.Primary.Cone          = 0.01
SWEP.Primary.ClipSize      = 10
SWEP.Primary.ClipMax       = 20
SWEP.Primary.DefaultClip   = 10
SWEP.Primary.Sound         = Sound( "Weapon_AK47.Single" )

SWEP.HeadshotMultiplier    = 3.4

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_357_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel            = "models/weapons/w_rif_ak47.mdl"

SWEP.IronSightsPos         = Vector(-7.58, -9.2, 0.55)
SWEP.IronSightsAng         = Vector(2.599, -1.3, -3.6)

function SWEP:SetZoom(state)
   if not (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer()) then return end
   if state then
      self:GetOwner():SetFOV(35, 0.5)
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
