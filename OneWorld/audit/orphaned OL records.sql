
select a.siobnm as f9860, b.siobnm as f9861 from obj7334.f9860 a full outer join obj7334.f9861 b on a.siobnm=b.siobnm where a.siobnm is NULL or b.siobnm is NULL and SIFUNO<>'BL' 
